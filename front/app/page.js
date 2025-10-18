import Image from "next/image";
import Link from "next/link"
import styles from "./page.module.css";

const getQualifications = async() => {
  const response = await fetch(`http://localhost:3000`, {
    method: "GET",
    headers : {
      "Accept": "application/json",
      "Content-Type" : "application/json"
    }
  })
  const json = await response.json()
  return json
}

const Home = async() => {
  const qualifications = await getQualifications()
  return (
    <div>
      <h1>資格</h1>
      <hr/>
      <table>
        <thead>
          <tr>
            <th>カテゴリー</th>
            <th>区分</th>
            <th>資格名</th>
            <th>参照</th>
            <th>編集</th>
          </tr>
        </thead>
        <tbody>
          {qualifications.map((q, idx) =>
            <tr key={q.id} className={idx % 2 == 0 ? 'even' : 'odd'}>
              <td>{q.category}</td>
              <td>{q.classification}</td>
              <td>{q.name_ja}</td>
              <td><Link href={`${process.env.NEXT_PUBLIC_URL}/qualifications/${q.id}`}>参照</Link></td>
              <td><Link href={`${process.env.NEXT_PUBLIC_URL}/qualifications/${q.id}/edit`}>編集</Link></td>
            </tr>
          )}
        </tbody>
      </table>
    </div>
  )
}

export default Home

